;; kitty.in.th-luko-sharpening.scm
;; v. 0.02
;; Author Kitt Tientanopajai <kitty@kitty.in.th>
;; Copyright (C) 2008 Kitt Tientanopajai"
;;
;; This is a free software and can be redistributed under GNU GPL version 2.
;; 
;; This script performs sharpening based on Luko's method.
;; Use layer instead edit -> fade. This can be used to adjust bias/strength of effects.
;; Orig. Luko's : contrast -> dark halo -> light halo
;; Modification : contrast -> dark halo && contrast -> light halo
;;
;; ChangeLogs
;; v0.02 - Mon, 15 Dec 2008 22:40:12 +0700
;; - Move to Filters menu
;; v0.03 - Mon, 15 Jun 2009 18:58:39 +0700
;; - Add USM opacity

(define (kitty.in.th-luko-sharpen image drawable usm-opacity dark-opacity light-opacity)
	(gimp-image-undo-group-start image)
	(let* (
		(layer-1 (car (gimp-layer-new-from-drawable drawable image))))

		(gimp-layer-set-name layer-1 "kitty.in.th - local contrast")
		(gimp-layer-set-mode layer-1 NORMAL-MODE)
		(gimp-image-add-layer image layer-1 -1)
		(gimp-layer-set-opacity layer-1 usm-opacity)
		(plug-in-unsharp-mask 1 image layer-1 40 0.18 0)

		(let* (
			(layer-2 (car (gimp-layer-new-from-drawable layer-1 image)))
			(layer-3 (car (gimp-layer-new-from-drawable layer-1 image))))

			(gimp-layer-set-name layer-2 "kitty.in.th - dark halo")
			(gimp-layer-set-mode layer-2 DARKEN-ONLY-MODE)
			(gimp-layer-set-opacity layer-2 dark-opacity)
			(gimp-image-add-layer image layer-2 -1)
			(plug-in-unsharp-mask 1 image layer-2 0.3 1.5 0)

			(gimp-layer-set-name layer-3 "kitty.in.th - light halo")
			(gimp-layer-set-mode layer-3 LIGHTEN-ONLY-MODE)
			(gimp-layer-set-opacity layer-3 light-opacity)
			(gimp-image-add-layer image layer-3 -1)
			(plug-in-unsharp-mask 1 image layer-3 0.3 1.5 0)
		)
	)
	(gimp-image-undo-group-end image)
	(gimp-displays-flush)
)

(script-fu-register
	"kitty.in.th-luko-sharpen"
	"<Image>/Filters/kitty.in.th/Luko's Sharpen"
	"kitty.in.th Luko's sharpening v.0.03"
	"Kitt Tientanopajai"
	"Copyright (C) 2008-2009 Kitt Tientanopajai"
	"June 15, 2009"
	"RGB RGBA GRAY GRAYA"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0
	SF-ADJUSTMENT "USM Opacity" '(50 0 100 1 5 0 0) 
	SF-ADJUSTMENT "Dark Opacity" '(25 0 100 1 5 0 0) 
	SF-ADJUSTMENT "Light Opacity" '(25 0 100 1 5 0 0))
